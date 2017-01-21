require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Lua < AbstractPhp71Extension
  init
  desc "This extension embeds the lua interpreter.."
  homepage "https://pecl.php.net/package/lua"
  url "http://pecl.php.net/get/lua-2.0.2.tgz"
  sha256 "eb11c68a8f2259ad02486f0a135785bd13c08166b6ec4a1301c862e72dc8a30d"
  head "https://github.com/laruence/php-lua.git"

  bottle do
    sha256 "dac413eacb1373d45f0c088b828c53bf2bbb9250c836135967534a52d4301374" => :sierra
    sha256 "56ab1fef692127db2b0fa6402e6a322a528b9becfb775eaf5bec8ea16bd6edc1" => :el_capitan
    sha256 "7262d3b0456abe253609eaa207b90f9645fd10358538f43aa1db3956652cc5dd" => :yosemite
  end

  depends_on "lua"

  def install
    Dir.chdir "lua-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-lua=#{Formula["lua"].opt_prefix}"
    system "make"
    prefix.install "modules/lua.so"
    write_config_file if build.with? "config-file"
  end
end
