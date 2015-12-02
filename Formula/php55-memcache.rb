require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Memcache < AbstractPhp55Extension
  init
  desc "This extension allows you to work with memcached through handy OO and procedural interfaces."
  homepage "https://pecl.php.net/package/memcache"
  url "https://pecl.php.net/get/memcache-2.2.7.tgz"
  sha256 "73006c02194a5a7c196c6488d449e5f8c75573a73568fe1a94b15157c147305d"
  head "https://svn.php.net/repository/pecl/memcache/trunk/"

  bottle do
    cellar :any_skip_relocation
    revision 1
    sha256 "686ffd66f5a806e39bbdae46db5f5aa213e648f805aac64d0b382f53eb312c17" => :el_capitan
    sha256 "1f7e7bd1537f9a168d37549fe876ae64f561f5ce93ee3ed587588e869a66a644" => :yosemite
    sha256 "8a4bf7119dbb58d281d2a2cc5443d0f4942f7ecfd2f73f52a38162b00b1f292c" => :mavericks
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
