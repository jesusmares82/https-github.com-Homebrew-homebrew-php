require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Mongodb < AbstractPhp70Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.3.3.tgz"
  sha256 "6c8f6b28ae69223df8f6c43ceef5776e60306910332c8f0c68d4096680a96a62"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    sha256 "cf0818904fa9da008715f9b720d13b6a474ced3c181c189428a8ed393ba9ba4c" => :high_sierra
    sha256 "67cb508c3a29a6bb194a045d8b605bae0f5a8cb4f7a6853f138f363d0543651a" => :sierra
    sha256 "25a26ffbe9aadde661c16f4dba1d46ef1733039d7277a314f00ddd4aeee0ce0a" => :el_capitan
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
