// data
const workSlides = {
  slides: [
    {
      images: [
        {
          title: "Cloud Native Web Application",
          path: "/cloud2.jpeg",
          link: "https://github.com/orgs/SparshRamchandani-CSYE6225Fall2023/repositories",
        },
        {
          title: "Spotify Clone",
          path: "/spotify.jpeg",
          link: "https://spotify-clone-io.vercel.app/",
        },
        {
          title: "Delivery Management System",
          path: "/springBoot.png",
          link: "https://github.com/sparshramchandani-NEU/Webtools_Final_Project",
        },
        {
          title: "VehiRentHub",
          path: "/ood.jpeg",
          link: "https://github.com/sparshramchandani-NEU/OOD_Final_Project",
        },
      ],
    },
    {
      images: [
       
        {
          title: "Echo Tweets",
          path: "/echoTweets.jpeg",
          link:"https://www.figma.com/file/y3Xj58MD9KCkKsIeFjaTHg/Sparsh_Ramchandani_Fall2023?type=design&node-id=548-657&mode=design"
        },
        {
          title: "RealTime Chat Application",
          path: "/chatApplication.jpeg",
          link:"https://github.com/neu-mis-info6150-fall-2022/final-project-devlovepers"
        },
        {
          title: "NU Merchandise",
          path: "/nuMerchandise.png",
          link:"https://github.com/karthiksneu/NU_Merchandise"
        },
        {
          title: "Bone Marrow Donation System",
          path: "/javaswing.jpeg",
          link:"https://github.com/sparshramchandani-NEU/AED_FinalProject"
        },
      ],
    },
  ],
};

//import swiper react componets
import { Swiper, SwiperSlide } from "swiper/react";

//import swiper styles
import "swiper/css";
import "swiper/css/free-mode";
import "swiper/css/pagination";

//import required modules
import { Pagination } from "swiper";

//icons
import { BsArrowRight } from "react-icons/bs";

//next Image
import Image from "next/image";
import Link from "next/link";

const WorkSlider = () => {
  return (
    <Swiper
      spaceBetween={10}
      // freeMode={true}
      pagination={{
        clickable: true,
      }}
      modules={[Pagination]}
      className="h-[280px] sm:h-[480px]"
    >
      {workSlides.slides.map((slide, index) => {
        return (
          <SwiperSlide key={index}>
            <div className="grid grid-cols-2 grid-rows-2 gap-4 cursor-pointer">
              {slide.images.map((image, index) => {
                return (
                  // <div className="bg-black flex items-center rounded-lg bg-black/10">
                  <Link href={`${image.link ? image.link : ""}`} className=" flex items-center">
                    <div className="relative rounded-lg overflow-hidden flex items-center justify-center group">
                      <div
                        className="flex items-center justify-center relative overflow-hidden group "
                        key={index}
                      >
                        {/* image */}
                        <Image
                          src={image.path}
                          width={500}
                          height={300}
                          alt=""
                          className="rounded-lg"
                        />
                        {/* overlay gradient */}
                        <div className="absolute inset-0 bg-gradient-to-l from-transparent via-[#e838cc] to-[#4a22bd] opacity-0 group-hover:opacity-80 transition-all duration-700"></div>
                        {/* title */}
                        <div className="absolute bottom-0 translate-y-full group-hover:-translate-y-10 group-hover:xl:-translate-y-20 transition-all duration-300">
                          <div className="flex items-center gap-x-2 text-[13px] tracking-[0.2em]">
                            {/* title part 1 */}
                            <div className="delay-100">{image.title}</div>
                            {/* title part 2 */}
                            {/* <div className="translate-y-[500%] group-hover:translate-y-0 transition-all duration-300 delay-150">
                            PROJECT
                          </div> */}
                            {/* icon */}
                            <div className="text-xl translate-y-[500] group-hover:translate-y-0 transition-all duration-300">
                              <BsArrowRight />
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </Link>
                  // </div>
                );
              })}
            </div>
          </SwiperSlide>
        );
      })}
    </Swiper>
  );
};

export default WorkSlider;
