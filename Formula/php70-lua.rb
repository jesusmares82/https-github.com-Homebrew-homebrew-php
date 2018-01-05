require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Lua < AbstractPhp70Extension
  init
  desc "This extension embeds the lua interpreter.."
  homepage "https://pecl.php.net/package/lua"
  url "https://pecl.php.net/get/lua-2.0.5.tgz"
  sha256 "bb49431ce5494ebebba98d9c477537df97234e13d4bd46529809ca1a2b8c287e"
  head "https://github.com/laruence/php-lua.git"

  bottle do
    sha256 "fc7c300cb3393adc3686c0ea83aacb87423f13f29790ab798385aea884a58b5f" => :sierra
    sha256 "d1d01f910adfe8d71b38c092f398b6b2880356d8f43baed8efd075da13c3bebc" => :el_capitan
    sha256 "76c9675ef52ce2973c71999f67dcb825b16ac497ccfb08cdcb7226c2cb3a97a3" => :yosemite
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
