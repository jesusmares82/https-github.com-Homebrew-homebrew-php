require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Tidy < AbstractPhp70Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "http://php.net/manual/en/book.tidy.php"
  bottle do
    cellar :any
    sha256 "b89a2bfc791d190a094dc30bea0b6f783c94d8c3cfd0a0a950c8482d66308039" => :yosemite
    sha256 "5e32e15d7c19cb5aa48888ff072419ef719cf68178a49b7270c40e299b556774" => :mavericks
    sha256 "5c80fd98cb7dffcb3fbbe7f19f89d3450f30a0ab1b1113e5abb0a16da9fa2b14" => :mountain_lion
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  def install
    Dir.chdir "ext/tidy"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                          "--with-tidy"
    system "make"
    prefix.install "modules/tidy.so"
    write_config_file if build.with? "config-file"
  end

  test do
    shell_output("php -m").include?("tidy")
  end
end

