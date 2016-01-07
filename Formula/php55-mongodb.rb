require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Mongodb < AbstractPhp55Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.1.2.tgz"
  sha256 "4cb80002dfb6be0805457ef0c9f4e91fd03c2e54baedac958ad1e498c741484d"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    sha256 "f5745fc3c76b1e8d1f80dc6f9a99c961377996c2aab7f4ba54d7bc943367a3ab" => :el_capitan
    sha256 "e57b458dff1ecfc87f01a687522145e31fb63b2508fafd5aa86f863c2a7eba29" => :yosemite
    sha256 "9dc10bc503617d17023093748f4cf1a5c2e56fc654060db7168d0fef71b6da33" => :mavericks
  end

  depends_on "openssl"

  def install
    Dir.chdir "mongodb-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-openssl-dir=#{Formula["openssl"].opt_prefix}"
    system "make"
    prefix.install "modules/mongodb.so"
    write_config_file if build.with? "config-file"
  end
end
