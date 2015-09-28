require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Memcache < AbstractPhp54Extension
  init
  homepage "https://pecl.php.net/package/memcache"
  url "https://pecl.php.net/get/memcache-2.2.7.tgz"
  sha256 "73006c02194a5a7c196c6488d449e5f8c75573a73568fe1a94b15157c147305d"
  head "https://svn.php.net/repository/pecl/memcache/trunk/"

  bottle do
    cellar :any_skip_relocation
    sha256 "8aecda311eed73d3b6ade2e4757bdd93f0cdfeebe5e7da48468dbc349d5d49e0" => :el_capitan
    sha256 "d103765806448b4db9649b715ffc25e67595884d8d2d096943b590f57d789f6c" => :yosemite
    sha256 "ad5b7871eb8fee3b09fccc158c00de73a401f66c0949424e49ab87516c11013d" => :mavericks
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
