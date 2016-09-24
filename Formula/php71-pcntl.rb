require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Pcntl < AbstractPhp71Extension
  init
  desc "Process Control support"
  homepage "http://php.net/manual/en/book.pcntl.php"
  bottle do
    cellar :any_skip_relocation
    sha256 "cc9c42e73d161b617a17580aeb7b2788e7c4579efcf4d63353df0cff731cbd2e" => :el_capitan
    sha256 "9464b39ae6cbde9b83b4eea0db579ba67b9d886a99dc40fa510578d9bb6dcb0c" => :yosemite
    sha256 "3ff9df3a7cc80a316881350b23de358d6398d88a244aa62790b2335c3b37f832" => :mavericks
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 3

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
