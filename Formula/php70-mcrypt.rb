require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Mcrypt < AbstractPhp70Extension
  init
  desc "An interface to the mcrypt library"
  homepage "http://php.net/manual/en/book.mcrypt.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    sha256 "5ee6b043e48060ab9de48cf4c5afc89c7611a1fa1d860879a7bab0a6a838b13a" => :yosemite
    sha256 "3943aff2b1a65cd035954a3b8728899e11f59a6e68eec06858f57ec9c41519a6" => :mavericks
    sha256 "f4dfe9b9c5efab0a1a6d74c20b50ea7b3e813c5fa5dd60b8073a36b5bf3f9b1d" => :mountain_lion
  end

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


