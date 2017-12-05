require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Molten < AbstractPhp55Extension
  init
  desc "PHP extension for Molten"
  homepage "https://github.com/chuan-yun/Molten"
  url "https://github.com/chuan-yun/Molten/archive/v0.1.1.tar.gz"
  sha256 "9502d915c406326ce16fc2bc428a04188c7d03da2fc95772baed0c6e284f1397"
  head "https://github.com/chuan-yun/Molten.git"
  revision 2

  bottle do
    cellar :any_skip_relocation
    sha256 "cba641f55883b07d5cc1eee0cff1b121b23de5091bd29208708da1fe2e0aee71" => :high_sierra
    sha256 "5e32b9e292886578fb2bfb17d1818ccbce3427378de33afe09c857786777d46e" => :sierra
    sha256 "a7bd75825240b46ddf93327d97f13b74b978ef7036c6280b8811ec999955d678" => :el_capitan
  end

  option "without-zipkin", "Disable zipkin headers"

  depends_on "php55-redis"
  depends_on "php55-memcached"
  depends_on "php55-mongodb"

  def install
    args = []
    args << "--enable-zipkin-header=yes" if build.with? "zipkin"

    safe_phpize

    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          *args
    system "make"
    prefix.install "modules/Molten.so"
    write_config_file if build.with? "config-file"
  end

  def config_file
    super + <<-EOS.undent
    ; Molten is transparency tool for application tracing it self module call.
    ; It trace php app core call and output zipkin/opentracing format trace log.
    ; Provides features about muliti trace sapi, multi sampling type,
    ; upload tracing status, module control and muliti sink type.
    ; get more details see: https://github.com/chuan-yun/Molten and then configure below
    [molten]
    molten.enable=1
    molten.sink_type=4
    molten.tracing_cli=0
    molten.sink_http_uri=http://127.0.0.1:9411/api/v1/spans
    molten.service_name=php_test
    molten.sampling_rate=1
    EOS
  end
end
