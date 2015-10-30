class PhpPlantumlwriter < Formula
  desc "Create UML diagrams from your PHP source"
  homepage "https://github.com/davidfuhr/php-plantumlwriter"
  url "https://github.com/davidfuhr/php-plantumlwriter/archive/1.6.0.tar.gz"
  sha256 "e0ee6a22877b506edfdaf174b7bac94f5fd5b113c4c7a2fc0ec9afd20fdc0568"

  bottle do
    cellar :any_skip_relocation
    sha256 "5124040d7593dc423a8c50eeb3e3961d47f66d017d76b7805c122b4edf74361a" => :el_capitan
    sha256 "a2ea4a2c54d13207042be78ed52afd7c782306638b05d4572773fec947bfdb13" => :yosemite
    sha256 "b4625f6b67bc7cdfa097041c58142a9a8dc69008089bd66f1bfd46c59af5b847" => :mavericks
  end

  depends_on "plantuml"
  depends_on "composer" => :build

  def install
    system "composer", "update"

    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/bin/php-plantumlwriter"
  end

  test do
    (testpath/"testClass.php").write <<-EOS.undent
      <?php
      class OneClass
      {
      }
    EOS

    (testpath/"testClass.puml").write <<-EOS.undent
      @startuml
      class OneClass {
      }
      @enduml
    EOS
    system "#{bin}/php-plantumlwriter write testClass.php > output.puml"
    system "diff", "-u", "output.puml", "testClass.puml"
  end
end
