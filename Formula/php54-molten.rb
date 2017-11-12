require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Molten < AbstractPhp54Extension
  init
  desc "PHP extension for Molten"
  homepage "https://github.com/chuan-yun/Molten"
  url "https://github.com/chuan-yun/Molten/archive/v0.1.1.tar.gz"
  sha256 "9502d915c406326ce16fc2bc428a04188c7d03da2fc95772baed0c6e284f1397"
  revision 1
  head "https://github.com/chuan-yun/Molten.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "8d7b55bb2a72bc7f8142c2a95307b1545aa808aab8b61dc8acb19ee16ff2b376" => :high_sierra
    sha256 "aa41ef2bb04aeebe521969c5f4b7f53dd36344226c0d3b82376438629b37e8e8" => :sierra
    sha256 "af3261c834ba4b1092470b30e773f6496e7043ac2912334983e4162c63be0711" => :el_capitan
  end

  option "without-zipkin", "Disable zipkin headers"

  depends_on "php54-redis"
  depends_on "php54-memcached"
  depends_on "php54-mongodb"

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
