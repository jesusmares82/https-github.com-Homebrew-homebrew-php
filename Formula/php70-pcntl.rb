require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Pcntl < AbstractPhp70Extension
  init
  desc "Process Control support"
  homepage "http://php.net/manual/en/book.pcntl.php"
  bottle do
    cellar :any_skip_relocation
    revision 6
    sha256 "7d56901509e4ccafc051e3d578ca8496981929aaff0eddc037d81ceb6d18c32b" => :el_capitan
    sha256 "649a907e9c38e42d110775bca7f358edf76c04ce2a8281ac0dbecaed0045d96f" => :yosemite
    sha256 "121bbaa27d232bab9c0396108910bcf305055c25b0364a8a9c9b10b0304ea9cd" => :mavericks
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  def install
    Dir.chdir "ext/pcntl"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking"
    system "make"
    prefix.install "modules/pcntl.so"
    write_config_file if build.with? "config-file"
  end
end
