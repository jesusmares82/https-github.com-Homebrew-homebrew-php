require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Mongodb < AbstractPhp72Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.2.9.tgz"
  sha256 "dac7f755001e454f41bd1ebf54a47754c524062d41244a75ea7ee3a9825a9d2b"
  head "https://github.com/mongodb/mongo-php-driver.git"
  revision 1

  bottle do
    sha256 "776b3fb3a3585c64c77cea9706f27f4e12595c2b9e5a392ece583e13ae178346" => :sierra
    sha256 "e4f92a034aad664771cd2df9c464b4556137f26097744da4e64e5cb51d715d5b" => :el_capitan
    sha256 "9dbca091c2e1e07fbad52c4d28b6743b9afafeb0aaccd6902f4f6158327323c6" => :yosemite
  end

  devel do
    url "https://pecl.php.net/get/mongodb-1.3.0beta1.tgz"
    sha256 "bd93a9cd6b5c10158bfced6b11366bf56e8f822bf39dbcf0b15603f2328479c5"
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
