require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Lua < AbstractPhp72Extension
  init
  desc "This extension embeds the lua interpreter.."
  homepage "https://pecl.php.net/package/lua"
  url "https://pecl.php.net/get/lua-2.0.2.tgz"
  sha256 "eb11c68a8f2259ad02486f0a135785bd13c08166b6ec4a1301c862e72dc8a30d"
  head "https://github.com/laruence/php-lua.git"

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
