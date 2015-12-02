require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Memcache < AbstractPhp54Extension
  init
  desc "This extension allows you to work with memcached through handy OO and procedural interfaces."
  homepage "https://pecl.php.net/package/memcache"
  url "https://pecl.php.net/get/memcache-2.2.7.tgz"
  sha256 "73006c02194a5a7c196c6488d449e5f8c75573a73568fe1a94b15157c147305d"
  head "https://svn.php.net/repository/pecl/memcache/trunk/"

  bottle do
    cellar :any_skip_relocation
    revision 1
    sha256 "b4153b632dead45c17eacfb1d05b0238a5cf04f02518c7e5952a120ddccfd814" => :el_capitan
    sha256 "37590fb132c0ee58718b0b174d46086aeb560b030b203e0c6616dec1f9aa703b" => :yosemite
    sha256 "f84acff48f2b2f79dda410b3663d2f1d775516e633b5fbed8e332c4cc9ca928d" => :mavericks
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
