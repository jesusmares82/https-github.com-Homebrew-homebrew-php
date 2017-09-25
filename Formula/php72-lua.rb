require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Lua < AbstractPhp72Extension
  init
  desc "This extension embeds the lua interpreter.."
  homepage "https://pecl.php.net/package/lua"
  url "https://pecl.php.net/get/lua-2.0.2.tgz"
  sha256 "eb11c68a8f2259ad02486f0a135785bd13c08166b6ec4a1301c862e72dc8a30d"
  head "https://github.com/laruence/php-lua.git"
  revision 1

  bottle do
    sha256 "0cb6c0d17da01a4d88dddc02a607c98ca1aff139813aed338e995fd45e2aaa6b" => :high_sierra
    sha256 "4c13f0967f688d658563767568723e1b68a60bfaa0ada28e821401108a0b193a" => :sierra
    sha256 "884016008cd30a683d185aa43e193a3fd2534c8e414a2b69ad0300770a36f224" => :el_capitan
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
