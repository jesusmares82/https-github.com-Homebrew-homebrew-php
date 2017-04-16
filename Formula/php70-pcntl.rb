require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Pcntl < AbstractPhp70Extension
  init
  desc "Process Control support"
  homepage "http://php.net/manual/en/book.pcntl.php"
  revision 9

  bottle do
    cellar :any_skip_relocation
    sha256 "bd79f58702065c148afeb30740c8808c6820498ceb004450eb23c31c37ceb82a" => :sierra
    sha256 "26fc16c4c5326e5c7f703cb3d16236d3e25d4af604115e1df59f3098baab1e17" => :el_capitan
    sha256 "342bb696e86c7f0839163a56a937f07ea7850f36c3b69c6d89aaf68ce7c9f356" => :yosemite
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
