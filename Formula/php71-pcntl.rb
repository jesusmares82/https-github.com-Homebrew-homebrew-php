require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Pcntl < AbstractPhp71Extension
  init
  desc "Process Control support"
  homepage "http://php.net/manual/en/book.pcntl.php"
  revision 11

  bottle do
    cellar :any_skip_relocation
    sha256 "0aa701fd3b7c1a472a5ced4cd4c931dbdfccd89cb2b7b8edc1c4dfefc545f108" => :sierra
    sha256 "5887ffc4d0f512c7d655c1826d66e63b730981b296aea6cb79cb39e198a05832" => :el_capitan
    sha256 "562efca76c9f7445d523d72c627b1bdc6f585a935cf487502ae8130be96d3c42" => :yosemite
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
