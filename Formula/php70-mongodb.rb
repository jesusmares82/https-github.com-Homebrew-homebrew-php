require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Mongodb < AbstractPhp70Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.1.9.tgz"
  sha256 "c4882991da323dfb0e60a43390a7a6cad27f632294f2becd44604dc9f7e90c3f"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    sha256 "783993328790309d2db253f1b1ce3edf5e7effeeca5ff3521cf3bdd024416556" => :sierra
    sha256 "fc20663eeb4082733801beef68e4399676dc7ee7798c0cb8ac94c72791c810dd" => :el_capitan
    sha256 "28532adaaae1267a2fb180e7f9e9df4573c8d889e0d402908925fdcda2acbcfa" => :yosemite
  end

  devel do
    url "https://pecl.php.net/get/mongodb-1.2.0alpha3.tgz"
    sha256 "295ff6792e734c5d0352efb0f2bb0c1dad25114d5c48bd98004d7650d742de3f"
    version "1.2.0alpha3"
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
