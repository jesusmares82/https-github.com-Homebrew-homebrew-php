require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Pcntl < AbstractPhp70Extension
  init
  desc "Process Control support"
  homepage "http://php.net/manual/en/book.pcntl.php"
  bottle do
    cellar :any_skip_relocation
    revision 12
    sha256 "f91bce3fd6e07b4759f518aa07385991a7499439222728697e91a9602b05a67d" => :el_capitan
    sha256 "408497ed0737c79d41a5beb4ea73072880028155f66a86b5c7aa1d9557aeaa99" => :yosemite
    sha256 "34870b7987807f7f69726a9cacb44ecdb81bdddadb7ae5cc6fbd671aa64f33a9" => :mavericks
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




