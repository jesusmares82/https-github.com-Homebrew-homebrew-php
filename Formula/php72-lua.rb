require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Lua < AbstractPhp72Extension
  init
  desc "This extension embeds the lua interpreter.."
  homepage "https://pecl.php.net/package/lua"
  url "https://pecl.php.net/get/lua-2.0.2.tgz"
  sha256 "eb11c68a8f2259ad02486f0a135785bd13c08166b6ec4a1301c862e72dc8a30d"
  head "https://github.com/laruence/php-lua.git"

  bottle do
    sha256 "18c721a21be2766bfb52c51c6d09e4ade72df4eabcd7823a0dddbfc48b0e7fcf" => :sierra
    sha256 "359d91e676b9bd6a7b560acc762f7c96f828474b7b356d0abc6b2a9af00b4605" => :el_capitan
    sha256 "be8455460ea88dba34b04c067500acfcb04ea7ac3b02c982b6346ff0f4e2d7c7" => :yosemite
  end

  depends_on "lua"

  def install
    Dir.chdir "lua-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-lua=#{Formula["lua"].opt_prefix}"
    system "make"
    prefix.install "modules/lua.so"
    write_config_file if build.with? "config-file"
  end
end
