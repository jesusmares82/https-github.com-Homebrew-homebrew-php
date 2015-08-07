require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Mcrypt < AbstractPhp70Extension
  init
  desc "An interface to the mcrypt library"
  homepage "http://php.net/manual/en/book.mcrypt.php"
  bottle do
    sha256 "42dca1ee87cedc16c8adb20a87f9eae0c3cc282543bf4145c7697a1426b8851c" => :yosemite
    sha256 "5de5ffc4d08e8bb01f8eda9c33c65e4775ed8b62e6748c098965a111c1591eef" => :mavericks
    sha256 "c0c081a2ae89b3f9204815aa894841ffe842b5818e049bc85d4c363ed953aa82" => :mountain_lion
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  depends_on "mcrypt"

  def install
    Dir.chdir "ext/mcrypt"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                          "--with-mcrypt=#{Formula["mcrypt"].opt_prefix}"
    system "make"
    prefix.install "modules/mcrypt.so"
    write_config_file if build.with? "config-file"
  end

  test do
    shell_output("php -m").include?("mcrypt")
  end
end

