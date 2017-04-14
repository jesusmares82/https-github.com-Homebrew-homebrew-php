require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Pcntl < AbstractPhp71Extension
  init
  desc "Process Control support"
  homepage "http://php.net/manual/en/book.pcntl.php"
  revision 11

  bottle do
    cellar :any_skip_relocation
    sha256 "87f659ef4dd1e056a563fd172fb01323309314a41559108735ef4e6157ad88d0" => :sierra
    sha256 "861625efb4d024b39ca6f2246c37a62304f2efca4954022b33673952298598f5" => :el_capitan
    sha256 "cdf04278d1725ead4da172bfd939fb193872088dfafe210800adee4aa1f09073" => :yosemite
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
