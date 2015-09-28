require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Memcache < AbstractPhp53Extension
  init
  homepage "https://pecl.php.net/package/memcache"
  url "https://pecl.php.net/get/memcache-2.2.7.tgz"
  sha256 "73006c02194a5a7c196c6488d449e5f8c75573a73568fe1a94b15157c147305d"
  head "https://svn.php.net/repository/pecl/memcache/trunk/"

  bottle do
    cellar :any_skip_relocation
    sha256 "9cae8ae4341f72794a0be67c5f74d12d5bb8fdb1107bcfa27f92e24794d7ad88" => :el_capitan
    sha256 "ffe67ac36bbbb17b1411700d423dbbdf11fefba9d4020b064deca87063d9a009" => :yosemite
    sha256 "02949e591a1a466e6d62f4972fc8d86b28dfbb23050888a652265f713ebf004a" => :mavericks
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
