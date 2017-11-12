require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Molten < AbstractPhp71Extension
  init
  desc "PHP extension for Molten"
  homepage "https://github.com/chuan-yun/Molten"
  url "https://github.com/chuan-yun/Molten/archive/v0.1.1.tar.gz"
  sha256 "9502d915c406326ce16fc2bc428a04188c7d03da2fc95772baed0c6e284f1397"
  revision 1
  head "https://github.com/chuan-yun/Molten.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "a3178e3a5def5318ce29c987d1b4b536731e5bff8b1047eccf15266816c475a7" => :high_sierra
    sha256 "55801e7be7c3abdb48c50e7649050aed218e1a42011878541a408abf70e1ae22" => :sierra
    sha256 "82f7bbf5959e1cf0ca219e1471e884920c5204df723567fc36c581710b9f453a" => :el_capitan
  end

  option "without-zipkin", "Disable zipkin headers"

  depends_on "php71-redis"
  depends_on "php71-memcached"
  depends_on "php71-mongodb"

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
