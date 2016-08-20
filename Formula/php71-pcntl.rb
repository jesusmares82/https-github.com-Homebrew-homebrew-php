require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Pcntl < AbstractPhp71Extension
  init
  desc "Process Control support"
  homepage "http://php.net/manual/en/book.pcntl.php"
  bottle do
    cellar :any_skip_relocation
    sha256 "e06500dd4fc72ba28b8bba6242f78d872b6098664a48d851953c8d306d9565f6" => :el_capitan
    sha256 "39f36465468bdbc17979fe3dc88b9f21e928c7e7883062d02679da1fe27d07ed" => :yosemite
    sha256 "88d02b1dda290e94196703f218c0bf407d991703b5177c18161e10cf881dfc70" => :mavericks
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 1

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
