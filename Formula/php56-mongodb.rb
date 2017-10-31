require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Mongodb < AbstractPhp56Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.3.2.tgz"
  sha256 "3a24f60c1bfd68736977e53f40cd5b50eccf42472277ce8101ca7eea0fe82788"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    sha256 "f78476f92876f520d50fadc0d612538653c6e634914c05d57dd95944f46e9e35" => :high_sierra
    sha256 "d8a4a3f88309eaae8f01fd6b8ec755e55642dcc353abc0956f77e81ef84e0654" => :sierra
    sha256 "9f024b1ff815c292ce8f52a22602acc0834aa36b4dd0655f8ca356554ef96eca" => :el_capitan
  end

  depends_on "openssl"

  def install
    Dir.chdir "mongodb-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-openssl-dir=#{Formula["openssl"].opt_prefix}"
    system "make"
    prefix.install "modules/mongodb.so"
    write_config_file if build.with? "config-file"
  end
end
