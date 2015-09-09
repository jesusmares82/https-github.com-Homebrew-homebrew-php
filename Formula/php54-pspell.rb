require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Pspell < AbstractPhp54Extension
  init
  homepage "http://php.net/manual/en/book.pspell.php"
  url      PHP_SRC_TARBALL
  sha256   PHP_CHECKSUM[:sha256]
  version  PHP_VERSION

  bottle do
    revision 1
    sha256 "3da924dd0d56a3dffbd79ac003e6440e9544e9f7062a8855a9bd84478353115b" => :yosemite
    sha256 "2d3518fb2f0f8bad93f7999294420f184358047785dbae56d44a5e0f23173f71" => :mavericks
    sha256 "6a03eb8222fc8d2670f9e678fa5c69d4c1877b7454d4ad165ea09ff5b9aa636d" => :mountain_lion
  end

  depends_on "aspell"

  def install
    Dir.chdir "ext/pspell"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-debug",
                          "--with-pspell=#{Formula['aspell'].opt_prefix}"
    system "make"
    prefix.install "modules/pspell.so"
    write_config_file if build.with? "config-file"
  end
end

