require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Pcntl < AbstractPhp70Extension
  init
  desc "Process Control support"
  homepage "http://php.net/manual/en/book.pcntl.php"
  bottle do
    cellar :any_skip_relocation
    revision 8
    sha256 "8d7283005716701c9d0544b077653efa7d2e5c6eaaa9e6beda2df39048b778a9" => :el_capitan
    sha256 "e92ed0ad27820a47274c66f4f492b9b6b23fee1c4e1911b6b10349e630fc721f" => :yosemite
    sha256 "10bfa65925f3a9a17e7e2019f6a967789437e13414bb839a2cf0b22a802ffbaf" => :mavericks
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
