require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Trace < AbstractPhp54Extension
  init
  desc "PHP extension and tool for low-overhead tracing"
  homepage "https://pecl.php.net/package/trace"
  url "https://pecl.php.net/get/trace-1.0.0.tgz"
  sha256 "068a5c168ee3fd4249cb41ea98a84affc1f8023d3b5745c0d8f9a305c2d672b1"
  head "https://github.com/Qihoo360/phptrace.git"

  def install
    Dir.chdir "trace-#{version}/extension" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make", "all", "build-cli"
    prefix.install "modules/trace.so"
    bin.install "../src/phptrace"

    write_config_file if build.with? "config-file"
  end

  test do
    system "#{bin}/phptrace", "-h"
  end
end
