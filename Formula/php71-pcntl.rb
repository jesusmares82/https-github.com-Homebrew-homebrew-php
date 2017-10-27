require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Pcntl < AbstractPhp71Extension
  init
  desc "Process Control support"
  homepage "https://php.net/manual/en/book.pcntl.php"
  revision 17

  bottle do
    cellar :any_skip_relocation
    sha256 "db908c37ee0c40ae3293d0ca4a0c95f633dec355ec14bbeb02b916b215b45844" => :high_sierra
    sha256 "79bccc7e2384b9bcc4a646c4e439c8810354040b7686e1c43f2a031aee697b96" => :sierra
    sha256 "d7d99205c8cd0ac66454b67108c9ed89db9b44416ed227250c6fa9e0c1e4e9ed" => :el_capitan
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
