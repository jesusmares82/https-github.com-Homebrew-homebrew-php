require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Mcrypt < AbstractPhp70Extension
  init
  desc "An interface to the mcrypt library"
  homepage "http://php.net/manual/en/book.mcrypt.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 2
    sha256 "20a2cb3dff4c26a4cd2867ee19fa014bf74a7e9d77204733179b1d8b7766ec3a" => :el_capitan
    sha256 "8c1347782cc2955b8ef1a0473abab5ca1cffb6c611f8b9bf7ee645ebe716253e" => :yosemite
    sha256 "25b132344a03323a316e6e7ab506c73a91bee3888d5d496540685de01eb13579" => :mavericks
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
