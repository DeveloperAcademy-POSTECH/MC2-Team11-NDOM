import Foundation

struct GilCatMapInformation {
    let size: GilCatSizeInformation
    let location: GilCatLocationInformation
    
    static let points: [GilCatMapInformation] = [
        GilCatMapInformation(size: .small,
                             location: GilCatLocationInformation(xPercent: 128.3333282470703,
                                                                 yPercent: 483.0)),
        GilCatMapInformation(size: .medium,
                             location: GilCatLocationInformation(xPercent: 297.6666615804036,
                                                                 yPercent: 447.6666564941406)),
        GilCatMapInformation(size: .small,
                             location: GilCatLocationInformation(xPercent: 529.999994913737,
                                                                 yPercent: 488.6666564941406)),
        GilCatMapInformation(size: .big,
                             location: GilCatLocationInformation(xPercent: 279.99998982747394,
                                                                 yPercent: 587.0)),
        GilCatMapInformation(size: .big,
                             location: GilCatLocationInformation(xPercent: 641.6666666666667,
                                                                 yPercent: 553.0)),
        GilCatMapInformation(size: .big,
                             location: GilCatLocationInformation(xPercent: 412.6666615804037,
                                                                 yPercent: 550.6666564941406)),
        GilCatMapInformation(size: .medium, // 달 위치
                             location: GilCatLocationInformation(xPercent: 796.0,
                                                                 yPercent: 129.0)),
        GilCatMapInformation(size: .big,
                             location: GilCatLocationInformation(xPercent: 81.66665649414062,
                                                                 yPercent: 592.6666564941406))
    
    ]
    
    static let box: GilCatMapInformation = GilCatMapInformation(size: .big,
                                                                location: GilCatLocationInformation(xPercent: 782.6666564941406,
                                                                                                    yPercent: 475.0))

}
