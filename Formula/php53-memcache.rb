require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Memcache < AbstractPhp53Extension
  init
  desc "This extension allows you to work with memcached through handy OO and procedural interfaces."
  homepage "https://pecl.php.net/package/memcache"
  url "https://pecl.php.net/get/memcache-2.2.7.tgz"
  sha256 "73006c02194a5a7c196c6488d449e5f8c75573a73568fe1a94b15157c147305d"
  head "https://svn.php.net/repository/pecl/memcache/trunk/"

  bottle do
    cellar :any_skip_relocation
    revision 1
    sha256 "ee0275709afede9ec43bdd7bb7940d7ee0895aeda56e09048d6c5b4332ff576d" => :el_capitan
    sha256 "26ed890171b49b8eeb7f07762f423b7f37da73bdc025561574a00b1e68e05ee8" => :yosemite
    sha256 "735c46df7104f9e7b0baebeba879092c0aa70e1829a8ad704400ba6da42ecf7e" => :mavericks
  end

  devel do
    url "https://pecl.php.net/get/memcache-3.0.8.tgz"
    sha256 "2cae5b423ffbfd33a259829849f6000d4db018debe3e29ecf3056f06642e8311"
  end

  def install
    Dir.chdir "memcache-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/memcache.so"
    write_config_file if build.with? "config-file"
  end
end
