require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Pcntl < AbstractPhp71Extension
  init
  desc "Process Control support"
  homepage "https://php.net/manual/en/book.pcntl.php"
  revision 18

  bottle do
    cellar :any_skip_relocation
    sha256 "b1981851e684664b0f1b3150dd9482c6eb1cdea055dec9be28d0417491e41d97" => :high_sierra
    sha256 "2e50e5d57ce7b72104a7a2881c81e3524018d07684501b1d746009c6fc52f200" => :sierra
    sha256 "308c4d76cf8c656ad0020ffb7728818e0626e337600ef2620427ca9bcd2e2ec2" => :el_capitan
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  def install
    Dir.chdir "ext/pcntl"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking"
    system "make"
    prefix.install "modules/pcntl.so"
    write_config_file if build.with? "config-file"
  end
end
