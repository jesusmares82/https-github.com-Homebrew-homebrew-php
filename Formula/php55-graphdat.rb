require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Graphdat < AbstractPhp55Extension
  init
  desc "Troubleshoot application and server performance."
  homepage "http://www.graphdat.com/"
  url "https://pecl.php.net/get/graphdat-1.0.3.tgz"
  sha256 "6b436c1f3f37d4d701f970a5d868e91711406b4b55bd78f79de916d21f8fb799"
  head "https://github.com/alphashack/graphdat-sdk-php.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "c350e80abc89ab0c74a76ebac8cc420cbb643677a0566ad235f367d8ef035199" => :el_capitan
    sha256 "43b68103c0de71c41441b3d2885fb5d7cd5aa81536d784d484e0c6d70d42af28" => :yosemite
    sha256 "c9c3f2aa21d63235f31bdde25d4db36ceb882c7ac7116976336d6c554a266c8b" => :mavericks
  end

  def install
    Dir.chdir "graphdat-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/graphdat.so"
    write_config_file if build.with? "config-file"
  end
end
