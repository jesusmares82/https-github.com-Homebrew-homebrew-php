require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Memcache < AbstractPhp56Extension
  init
  homepage 'https://pecl.php.net/package/memcache'
  url 'https://pecl.php.net/get/memcache-2.2.7.tgz'
  sha256 '73006c02194a5a7c196c6488d449e5f8c75573a73568fe1a94b15157c147305d'
  head 'https://svn.php.net/repository/pecl/memcache/trunk/'

  bottle do
    cellar :any_skip_relocation
    sha256 "a869f9bd49a8d975a7b2f836784f6d6a1a05135562fc2b42e5dff0315902b2ce" => :el_capitan
    sha256 "e876c59029000634519f46375fbbc37fb6f339bcedc81dc0ee40070577b284c6" => :yosemite
    sha256 "34445de0a6b7c486ef2cd0289b37ca3519a7530c488c43e82c4ec91fdbc09b7b" => :mavericks
  end

  devel do
    url 'https://pecl.php.net/get/memcache-3.0.8.tgz'
    sha256 '2cae5b423ffbfd33a259829849f6000d4db018debe3e29ecf3056f06642e8311'
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
