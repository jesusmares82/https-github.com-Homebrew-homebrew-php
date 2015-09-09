require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Pcntl < AbstractPhp70Extension
  init
  desc "Process Control support"
  homepage "http://php.net/manual/en/book.pcntl.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    cellar :any
    revision 1
    sha256 "bb49a3991d7a5920551da121a0536ab6cc7b7286dc68a9ecb8e414d80963e9ff" => :yosemite
    sha256 "8ecf10b020d9913b62d08e6c434251615fd8c0b607d5c450367fba5efb7966ac" => :mavericks
    sha256 "691431e289d47341efdcb80924a315360d84cc12321cf2e75d579dc1a10984fe" => :mountain_lion
  end

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

  test do
    shell_output("php -m").include?("pcntl")
  end
end


