require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Memcache < AbstractPhp56Extension
  init
  desc "This extension allows you to work with memcached through handy OO and procedural interfaces."
  homepage "https://pecl.php.net/package/memcache"
  url "https://pecl.php.net/get/memcache-2.2.7.tgz"
  sha256 "73006c02194a5a7c196c6488d449e5f8c75573a73568fe1a94b15157c147305d"
  head "https://svn.php.net/repository/pecl/memcache/trunk/"

  bottle do
    cellar :any_skip_relocation
    revision 1
    sha256 "dcdbeafd1c8f24abec63574f70cc60175be2a1ae52e4f35e890a2eefdcbdec23" => :el_capitan
    sha256 "60d501f0c62b7d09c1b8b9ab247c9a90ada5e916b984f04a8afc54916b71d040" => :yosemite
    sha256 "3e61eac011953dcc2780f0e76e27602b38c41563d6e8515bf61023a6c9824bb7" => :mavericks
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
