require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Pcntl < AbstractPhp71Extension
  init
  desc "Process Control support"
  homepage "http://php.net/manual/en/book.pcntl.php"
  revision 13

  bottle do
    cellar :any_skip_relocation
    sha256 "f1c42d500590c0f4c245798238ddcf143a4cb050fade74b89f2bee9270df4f9f" => :sierra
    sha256 "9a50d4e8e82bd3165cdab74acc408153695c435be220c10d76fba8a2d6aef628" => :el_capitan
    sha256 "8f8789293252faa3d38207e0f94fdda0f105833a90a42392fa76c100bf2d8d4b" => :yosemite
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

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
