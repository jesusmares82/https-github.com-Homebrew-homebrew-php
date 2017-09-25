require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Molten < AbstractPhp72Extension
  init
  desc "PHP extension for Molten"
  homepage "https://github.com/chuan-yun/Molten"
  url "https://github.com/chuan-yun/Molten/archive/v0.1.1.tar.gz"
  sha256 "9502d915c406326ce16fc2bc428a04188c7d03da2fc95772baed0c6e284f1397"
  head "https://github.com/chuan-yun/Molten.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "4ed6af50677765ea89a414b5e48fd3198c432ca07e5f2700aa6bde935e97859d" => :high_sierra
    sha256 "4e3d5d966eac08ca55dc82fbda500eccce1e0316f56bc19725ad4e2f3efc4b84" => :sierra
    sha256 "179434cd42f5ef0ee39abaa669964b1dc8c8d4e32fe61daec9f3c0d06dfb3776" => :el_capitan
  end

  option "without-zipkin", "Disable zipkin headers"

  depends_on "php72-redis"
  depends_on "php72-memcached"
  depends_on "php72-mongodb"

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
