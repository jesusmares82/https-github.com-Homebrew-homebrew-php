require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Molten < AbstractPhp55Extension
  init
  desc "PHP extension for Molten"
  homepage "https://github.com/chuan-yun/Molten"
  url "https://github.com/chuan-yun/Molten/archive/v0.1.1.tar.gz"
  sha256 "9502d915c406326ce16fc2bc428a04188c7d03da2fc95772baed0c6e284f1397"
  revision 1
  head "https://github.com/chuan-yun/Molten.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "455732c580ef91e71dfda6b0b8dd73761727ab1bc40038db4b63327abab3a9bf" => :high_sierra
    sha256 "7daef65e453a436e5d19db5a4931b5502b278002dddd4db639e7d015fa9f7730" => :sierra
    sha256 "eb82484aadb8f5b876d5db0cec8d6f8a458fdcbce3b7b20ae59b1f99d281abde" => :el_capitan
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
