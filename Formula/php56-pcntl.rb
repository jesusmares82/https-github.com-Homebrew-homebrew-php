require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Pcntl < AbstractPhp56Extension
  init
  homepage "http://php.net/manual/en/book.pcntl.php"
  url      PHP_SRC_TARBALL
  sha256   PHP_CHECKSUM[:sha256]
  version  PHP_VERSION

  bottle do
    cellar :any
    sha256 "3767819a9fb0dfd31b6f528ea473062c1ccf60c9487e637b0b5d660ee6c57824" => :yosemite
    sha256 "723b5472e6f9fb88a0473fba3aaad0d177449e34c930f2ee6ea7deef4af209ff" => :mavericks
    sha256 "58ec4da37a0d2ac7235f54f615436e424cb50e4e7ec7bf8e747395fbca1d9573" => :mountain_lion
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
end

