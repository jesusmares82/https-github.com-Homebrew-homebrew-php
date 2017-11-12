require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Molten < AbstractPhp70Extension
  init
  desc "PHP extension for Molten"
  homepage "https://github.com/chuan-yun/Molten"
  url "https://github.com/chuan-yun/Molten/archive/v0.1.1.tar.gz"
  sha256 "9502d915c406326ce16fc2bc428a04188c7d03da2fc95772baed0c6e284f1397"
  revision 1
  head "https://github.com/chuan-yun/Molten.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "6487684b03f930231879e077443de8dbb0b3f1cd96691c17d9d030599e4694b4" => :high_sierra
    sha256 "bdf4e061d8d26914f0ef6b235879bdc45902f2c657341114497d99f0deda5aed" => :sierra
    sha256 "edceac08cc665d24dcc29f090ad33bdab939354547fcc62f32cd9a1e80845d4c" => :el_capitan
  end

  option "without-zipkin", "Disable zipkin headers"

  depends_on "php70-redis"
  depends_on "php70-memcached"
  depends_on "php70-mongodb"

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
