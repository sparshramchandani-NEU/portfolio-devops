//links
import Link from "next/link";

// icons
import { RiGithubFill, RiLinkedinBoxFill } from "react-icons/ri";
import { BiLogoGmail } from "react-icons/bi";

const Socials = () => {
  return (
    <div className="flex items-center gap-x-5 text-2xl">
      <Link href={"http://linkedin.com/in/sparsh-ramchandani"} className="hover:text-accent transition-all duration-300">
        <RiLinkedinBoxFill />
      </Link>
      <Link href={"https://github.com/sparshramchandani-NEU"} className="hover:text-accent transition-all duration-300">
        <RiGithubFill />
      </Link>
      <Link href={`mailto:${'sparshramchandani1512is@gmail.com'}`} className="hover:text-accent transition-all duration-300">
        <BiLogoGmail />
      </Link>
    </div>
  );
};

export default Socials;
