require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Mcrypt < AbstractPhp55Extension
  init
  desc "An interface to the mcrypt library"
  homepage "http://php.net/manual/en/book.mcrypt.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    revision 9
    sha256 "4a86e7bd1bae3b7a77286935e48a0cb1e6c06206f691740630a289f55a421b91" => :el_capitan
    sha256 "a324a6973b40af5444b40e051a70903d960bb3f8879a1c45b43ec80f374ac081" => :yosemite
    sha256 "fa52c63ec1647d103536be6ddee1966b099dc234e203da9dfe013870a246ce16" => :mavericks
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
end







