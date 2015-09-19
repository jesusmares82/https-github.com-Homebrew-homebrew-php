require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Judy < AbstractPhp56Extension
  init
  homepage 'https://github.com/orieg/php-judy'
  url 'https://pecl.php.net/get/Judy-1.0.2.tgz'
  sha256 '6b913af2c44ac84a2224fecf8a81ddcb0c753252cafd153cb0e9d7c33a333118'
  head 'https://github.com/orieg/php-judy.git'

  bottle do
    cellar :any
    sha256 "ae63e3851ec7a2e5889e5676a9d2aac1deef451ae98041081e99a7ad3f737fa7" => :el_capitan
    sha256 "a1ed7e715752941540345aa775e250ee4aed0d5aaa9a53b93682c562d7f6504b" => :yosemite
    sha256 "c033a1b8f5566d9a82ab899849b0d576b54eec737ea9cf0f5e1844075e69d4a1" => :mavericks
  end

  depends_on "judy"

  def install
    Dir.chdir "judy-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/judy.so"
    write_config_file if build.with? "config-file"
  end
end
