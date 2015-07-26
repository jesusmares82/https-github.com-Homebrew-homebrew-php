require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Tidy < AbstractPhp70Extension
  init
  desc "Tidy HTML clean and repair utility"
  homepage "http://php.net/manual/en/book.tidy.php"
  bottle do
    cellar :any
    sha256 "1de84dd98ddcfd196fccd1157067957ac78318a0c4ba3794aedd679e9d1a74a0" => :yosemite
    sha256 "3d66f302a54f8365586fa0301f8e74a2c24269329b737bf82fc65fc6a998d31a" => :mavericks
    sha256 "194294c113606ca65b869516ecf803038c3d3104351a4acf6b90b9048b4c95d8" => :mountain_lion
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

