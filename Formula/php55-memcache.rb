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
    sha256 "159e887ed087a69bdac4a997cd0e226b1079c2de15baf022837f25073ede4fef" => :el_capitan
    sha256 "5f367b2e2b796d7f5d7888e4a5ac84e5cfdd3e9ac726c1d4852ee573f14d3b6b" => :yosemite
    sha256 "746f10296ba211557a068b64c348a429a1613fb6c5ba565a87e55832ab995a29" => :mavericks
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
