//
//  UserInputKeys.swift
//  DittoFashionMarketBeta
//
//   Health Track


import Foundation

// MARK: - Keys
enum Keys {
    static var signupAccessToken: String { return "signupAccessToken" }
    static var accessToken: String { return "accessToken" }
    static var deviceId: String { return "deviceId" }
    static var password: String {return "password"}
    static var userName: String {return "userName"}
    static var firstLaunch: String {return "FirstLaunch"}
}

// MARK: - Api Keys
//=======================
enum ApiKey {
    static var success: String { return "success" }
    static var lastIndex: String { return "lastIndex" }
    static var restData: String { return "restData" }
    static var contactList: String { return "contactList" }
    static var ocdArray: String { return "ocdArray" }
    static var isSubscribed: String { return "isSubscribed" }
    static var financeLink: String { return "finance_link" }
    static var userData: String { return "userData" }
    static var reportUrl: String { return "reportUrl" }
    
    static var contacts: String { return "contacts" }
    static var emails: String { return "emails" }
    static var invitationLink: String { return "invitationLink" }
    static var isInviteAllEmail: String { return "isInviteAllEmail" }
    static var isInviteAllPhone: String { return "isInviteAllPhone" }
    static var joinStatus: String { return "joinStatus" }
    static var requestId: String { return "requestId" }
    static var imgUrl: String { return "imgUrl" }
    static var totalPendingReq: String { return "totalPendingReq" }
    
    static var statusCode: String { return "statusCode" }
    static var status: String { return "status" }
    static var CODE: String { return "CODE" }
    static var result: String { return "RESULT" }
    static var data: String {return "data"}
    static var message: String { return "message" }
    static var Authorization: String { return "Authorization" }
    static var userId: String { return "userId" }
    static var customPayloadId: String { return "customPayloadId" }
    static var name: String { return "name" }
    static var firstName: String { return "first_name" }
    static var lastName: String { return "lastName" }
    static var email: String { return "email" }
    static var password: String { return "password" }
    static var confirmPassword: String { return "confirmPassword" }
    static var gender: String { return "gender" }
    static var phone: String { return "phone" }
    static var dob: String { return "dob" }
    static var address: String { return "address" }
    static var lat: String { return "latitude" }
    static var long: String { return "longitude" }
    static var countryId: String { return "country_id" }
    static var stateId: String { return "state_id" }
    static var cityId: String { return "city_id" }
    static var deviceId: String { return "deviceId" }
    static var deviceToken: String { return "deviceToken" }
    static var deviceType: String { return "device_type" }
    static var ios: String { return "ios" }
    static var saveCard: String { return "savecard" }
    static var cardId: String { return "card_id" }
    static var customerId: String { return "customer_id" }
    static var OTPverifyToken: String { return "OTPverifyToken" }
    static var OTP: String { return "OTP" }
    static var underScoreId: String {return "_id"}
    static var isAddressVerified: String {return "isAddressVerified"}
    static var lowerCaseType: String { return "lowerCaseType" }
    static var platform: String { return "platform" }
    static var socialLoginType: String {return "socialLoginType"}
    static var token: String { return "token" }
    static var refreshToken: String { return "refresh_token" }
    static var resetSuccess: String { return "resetSuccess" }
    static var oldPassword: String { return "oldPassword" }
    static var oldCountryCode: String { return "oldCountryCode" }
    static var newCountryCode: String { return "newCountryCode" }
    static var oldMobileNo: String { return "oldMobileNo" }
    static var newMobileNo: String { return "newMobileNo" }
    static var isPrivate: String { return "isPrivate" }
    static var news: String { return "news" }
    static var cd: String { return "cd" }
    static var county: String { return "county" }
    static var place: String { return "place" }
    static var keywords: String { return "keywords" }
    static var categories: String { return "categories" }
    static var `default`: String { return "default" }
    static var createdAtDate: String { return "createdAtDate" }
    static var sldl: String { return "sldl" }
    static var sldu: String { return "sldu" }
    static var socialId: String {return "socialId"}
    static var countryCode: String { return "countryCode" }
    static var mobileNo: String { return "mobileNo" }
    static var code: String { return "code" }
    static var profile: String {return "profile"}
    static var images: String {return "images"}
    static var contentType: String { return "Content-Type" }
    static var primaryLogin: String { return "primaryLogin" }
    static var accessToken: String { return "accessToken" }
    static var id: String { return "id"}
    static var matchId: String { return "match_id"}
    static var initial: String { return "init"}
    static var reportType: String { return "report_type"}
    static var reportName: String { return "reportName"}
    static var description: String { return "description"}
    static var timezone: String { return "timezone"}
    static var api_key: String { return "api_key"}
    static var apiKey: String { return "apiKey"}
    static var childDetails: String { return "childDetails"}
    static var isExistingUser: String {return "isExistingUser"}
    static var fb: String { return "fb" }
    static var facebookId: String { return "facebook_id" }
    static var googleId: String { return "google_id" }
    static var loginType: String {return "loginType"}
    static var type: String {return "type"}
    static var sourceUrl: String {return "sourceUrl"}
    static var identification: String {return "identification"}
    static var religion: String {return "religion"}
    static var educationLevel: String {return "educationLevel"}
    static var religionId: String {return "religionId"}
    static var educationLevelId: String {return "educationLevelId"}
    static var occupation: String {return "occupation"}
    static var occupationId: String {return "occupationId"}
    static var politicalIdentification: String {return "politicalIdentification"}
    static var culturalHeritages: String {return "culturalHeritages"}
    static var culturalHeritageId: String {return "culturalHeritageId"}
    static var politicalId: String {return "politicalIdentificationId"}
    static var text: String {return "text"}
    static var shouldUseLatestNewsApi: String {return "shouldUseLatestNewsApi"}
    static var isUserPrivate: String {return "isUserPrivate"}
    static var stateCode: String {return "stateCode"}
    static var isMyFollower: String {return "isMyFollower"}
    
    static var partyId: String {return "partyId"}
    static var interestedPoliticalParty: String {return "interestedPoliticalParty"}
    static var accept: String { return "Accept" }
    static var page: String { return "page" }
    static var pageNo: String { return "pageNo" }
    static var endDate: String { return "endDate" }
    static var current_page: String { return "current_page" }
    static var lastPage: String { return "last_page" }
    static var latitude: String { return "latitude" }
    static var longitude: String { return "longitude" }
    static var price: String { return "price" }
    static var receiverId: String { return "receiverId" }
    static var eventId: String { return "eventId" }
    static var eventDate: String { return "eventDate" }
    static var startDate: String { return "startDate" }
    static var isProfileComplete: String { return "isProfileComplete" }
    static var fullName: String { return "fullName" }
    static var profilePicture: String { return "profilePicture" }
    static var liveStreamStatus: String { return "liveStreamStatus" }
    static var totalFollowers: String { return "totalFollowers" }
    static var totalFollowing: String { return "totalFollowing" }
    static var totalEarnedPoints: String { return "totalEarnedPoints" }
    static var earnedBadge: String { return "earnedBadge" }
    static var commonAccountDetails: String { return "commonAccountDetails" }
    static var totalForums: String { return "totalForums" }
    static var totalSavedPodcast: String { return "totalSavedPodcast" }
    static var accountLevel: String { return "accountLevel" }
    static var next_hit: String { return "next_hit" }
    static var nextHit: String { return "next_hit" }
    static var total_page: String { return "total_page" }
    static var limit: String { return "limit" }
    static var perPage: String { return "per_page" }
    static var language: String { return "language" }
    static var category: String { return "category" }
    static var domain: String { return "domain" }
    static var start_date: String { return "start_date" }
    static var end_date: String { return "end_date" }
    static var domains: String { return "domains" }
    static var contactsArr: String { return "contactsArr" }

    static var followingList: String { return "followingList" }
    static var followersList: String { return "followersList" }
    static var userToFollowId: String { return "userToFollowId" }
    static var isFollows: String { return "isFollowing" }
    static var otherUserId: String { return "otherUserId" }
    static var total: String { return "total" }
    static var videoUrl: String { return "videoUrl" }
    static var videoStatus: String { return "videoStatus" }
    static var coordinates: String { return "coordinates" }
    static var location: String { return "location" }
    static var forumId: String { return "forumId" }
    static var postId: String { return "postId" }
    static var commentId: String { return "commentId" }
    static var imageUrl: String { return "imageUrl" }
    static var url: String { return "url" }
    static var media: String {return "media"}
    static var annualIncomeId: String { return "annualIncomeId" }
    static var residenceStatus: String { return "residenceStatus" }
    static var annualHouseHoldIncome: String { return "annualHouseHoldIncome" }
    static var interests: String { return "interests" }
    static var interestId: String { return "interestId" }
    static var interestsIds: String { return "interestsIds" }
    static var requestedInterest: String { return "requestedInterest" }
    static var residence: String { return "residential" }
    static var yes: String { return "Y" }
    static var no: String { return "N" }
    static var incomeRange: String { return "incomeRange" }
    static var isGoogleLogin: String { return "isGoogleLogin" }
    static var isEmailVerified: String { return "isEmailVerified" }
    static var isSocialAccount: String { return "isSocialAccount" }
    static var isFacebookLogin: String { return "isFacebookLogin" }
    static var userName: String { return "userName" }
    static var isMobileVerified: String { return "isMobileVerified" }
    static var isProfileCompleted: String { return "isProfileCompleted" }
    static var comment: String { return "comment" }
    static var searchKey: String { return "searchKey" }
    static var otherUserBlocked: String { return "otherUserBlocked" }
    static var blockedByOtherUsers: String { return "blockedByOtherUsers" }
    static var createdAt: String { return "createdAt" }
    static var updatedAt: String { return "updatedAt" }
    static var created: String { return "created" }
    static var sortBy: String { return "sortBy" }
    static var userList: String { return "userList" }
    static var isFollowing: String { return "isFollowing" }
    static var podcastList: String { return "podcastList" }
    static var episodeList: String { return "episodeList" }
    static var podcastId: String { return "podcastId" }
    static var podcastStateId: String { return "stateId" }
    static var bio: String { return "bio" }
    static var phones: String { return "phones" }
    static var websiteUrl: String { return "websiteUrl" }
    static var hours: String { return "hours" }
    static var minutes: String { return "minutes" }
    static var seconds: String { return "seconds" }
    static var episodeTitle: String { return "episodeTitle" }
    static var episodeDescription: String { return "episodeDescription" }
    static var episodeUrl: String { return "episodeUrl" }
    static var episodeThumbnailImage: String { return "episodeThumbnailImage" }
    static var duration: String { return "duration" }
    static var existing: String { return "existing" }
    static var pinnedCommentId: String { return "pinnedCommentId" }
    static var pinned: String { return "pinned" }
    static var commentDate: String { return "commentDate" } 
    static var pinnedCommentObject: String { return "pinnedCommentObject" }
    static var tag: String { return "tag" }
    static var index: String { return "index" } 
    static var referredReferralCode: String { return "referredReferralCode" }
    static var referralCode: String { return "referralCode" }
    static var ocdIds: String { return "ocdIds" }
    static var ocdId: String { return "ocdId" }
    static var rewardPoints: String { return "rewardPoints" }
    static var userMention: String { return "userMention" }
    static var representativeId: String { return "representativeId" }
    static var shouldAskToJoinGuestJoinedForums: String { return "shouldAskToJoinGuestJoinedForums" }
    static var rating: String { return "rating" }
    static var isFeedbackGiven: String { return "isFeedbackGiven" }
    static var forums: String { return "forums" }
    static var electionDate: String { return "electionDate" }
    static var generalElectionDate: String { return "generalElectionDate" }
    static var primaryDate: String { return "primaryDate" }
    static var officeSought: String { return "officeSought" }
    static var generalRunoffDate: String { return "generalRunoffDate" }
    static var primaryRunoffDate: String { return "primaryRunoffDate" }
    static var episodeId: String { return "episodeId" }
    static var advertisementCategories: String { return "advertisementCategories" }
    static var advertisementCategoryId: String { return "advertisementCategoryId" }
    static var categoryName: String { return "categoryName" }
    static var isSelected: String { return "isSelected" }
    static var surveyType: String { return "survey_type" }
    static var billType: String { return "billType" }
    static var region: String { return "region" }
    static var source: String { return "source" }
    
    static var representatives: String { return "representatives" }
    static var elections: String { return "elections" }
    static var electionType: String { return "electionType" }
    static var podcasts: String { return "podcasts" }
    static var users: String { return "users" }
    static var voterRegisterationUrl: String { return "voterRegisterationUrl" }
    static var legislationId: String { return "legislationId" }
    static var source_id: String { return "source_id" }
    static var cid: String { return "cid" }
    static var avgRating: String { return "avgRating" }
//    static var country: String { return "country" }
    static var postalCode: String { return "postalCode" }
    static var hashTag: String { return "hashTag" }
    static var reason: String { return "reason" }
    static var reasonId: String { return "reasonId" }
    static var fname: String { return "firstName" }
    static var mname: String { return "middleName" }
    static var lname: String { return "lastName" }
    static var sponsorId: String { return "sponsor_id" }
    static var iosRecieptToken: String { return "iosRecieptToken" }
    static var feedbackId: String { return "feedbackId" }
    static var surveyId: String { return "surveyId" }
    static var commercial: String { return "commercial" }
    static var currentLatitude: String { return "currentLatitude" }
    static var currentLongitude: String { return "currentLongitude" }
    static var pagenumber: String { return "page_number" }
    static var results: String { return "results" }
    static var shouldReceiveEmail: String { return "shouldReceiveEmail" }
    static var originalRaceType: String { return "originalRaceType" }
    static var createdDate: String { return "createdDate" }
    static var showProfileReminderPopUp: String { return "showProfileReminderPopUp" }
    static var joinGuestAccountForums: String { return "joinGuestAccountForums" }
    static var stage: String { return "stage" }
    static var povId: String { return "povId" }
    
    // Third Party Apikeys
    //========================
    static var authId: String { return "auth-id" }
    static var authToken: String { return "auth-token" }
    static var prefix: String { return "prefix" }
    static var cityFilter: String { return "city_filter" }
    static var city: String { return "city" }
    static var state: String { return "state" }
    static var street: String { return "street" }
    static var zipcode: String { return "zipcode" }
    static var stateAbbreviation: String { return "state_abbreviation" }
    static var candidates: String { return "candidates" }
    static var suggestions: String { return "suggestions" }
    static var title: String { return "title" }
    static var thumbnailImage: String { return "thumbnailImage" }
    static var subject: String { return "subject" }
    static var domainNot: String { return "domain_not" }
    static var key: String { return "key" }
    static var search: String { return "search" }
    static var referer: String { return "Referer" }
    static var preferGeolocation: String { return "prefer_geolocation" }
    static var currentPeriodExpiry: String { return "currentPeriodExpiry" }
    
    // Live Streaming
    static var channelName: String { return "channelName" }
    
    // For maintaining multidevice login
    static var userDeviceID: String { return "userDeviceId"}
    
    // For Notification
    static var badgeCount: String { return "badge"}
    static var sound: String { return "sound"}
    static var body: String { return "body"} 
    static var liveUserData: String { return "liveUserData"}
    static var notificationType: String { return "type"}
    static var notificationId: String { return "notificationId"}
    static var alert: String { return "alert" }
    static var apsData: String { return "aps" }
    static var followerData: String { return "followerData" }
    static var entityId: String { return "entityId" }
    static var postData: String { return "postData" }
    static var forumData: String { return "forumData" }
    static var forumMemberData: String { return "forumMemberData" }
    static var followerId: String { return "followerId" }
    static var podcastData: String { return "podcastData" }
    static var legislationData: String { return "legislationData" }
    
    // for chat
    static var senderId: String { return "senderId" }
    static var isAdmin: String { return "isAdmin" }
    static var chatStatus: String { return "chatStatus" }
    static var lastMsgID: String { return "lastMsgId" }
    static var groupID: String { return "groupId" }
    static var groupName: String { return "groupName" }
    static var groupImage: String { return "groupImage" }
    static var userID: String { return "userID" }
    static var userIds: String { return "userIds" }
    static var unReadMsgCount: String { return "unReadMsgCount" }
    static var listCategory: String { return "listCategory" }
    static var lastMsgCreatedAt: String { return "lastMsgCreatedAt" }
    static var chatId: String { return "chatId" }
    static var chatIds: String { return "chatIds" }
    static var chatListIds: String { return "chatListIds" }
    static var userInfo: String { return "userInfo" }
    static var roomKey: String { return "roomKey" }
    static var ids: String { return "ids" }
    static var groupId: String { return "groupId" }
    static var userDeleteMsgStatus: String { return "userDeleteMsgStatus" }
    static var groupUsers: String { return "groupUsers" }
    static var localMessageId: String { return "localMessageId" }
    static var chatType: String { return "chatType" }
    static var members: String { return "members" }
    static var localChatId: String { return "localChatId" }
    static var messageType: String { return "messageType" }
    static var isDelete: String { return "isDelete" }
    static var actionType: String { return "actionType" }
    static var ackData: String { return "ackData" }
    static var messageId: String { return "messageId"}
    static var deliveredTo: String { return "deliveredTo" }
    static var seenBy: String { return "seenBy" }
    static var messageIds: String { return "messageIds"}
    static var ackAction: String { return "ackAction" }
    static var ackIds: String { return "ackIds" }
    static var statusAction: String { return "statusAction" }
    static var time: String { return "time" }
    static var mediaUrl: String { return "mediaUrl" }
    static var mediaType: String { return "mediaType" }
    static var caption: String { return "caption" }
    static var povText: String { return "povText" }
    static var isFollowersOnly: String { return "isFollowersOnly" }
    static var videoLength: String { return "videoLength" }
    static var localFileInfo: String { return "localFileInfo" }
    static var localFilename: String { return "localFilename" }
    static var completedProfileStep: String { return "completedProfileStep" }
    static var dobInMilliSeconds: String { return "dobInMilliSeconds" }
    static var referCode: String { return "referCode" }
    static var signUpReferralCode: String { return "signUpReferralCode" }
    static var isRep: String { return "isRep" }
    static var repLastName: String { return "repLastName" }
    static var repName: String { return "repName" }
    static var repEmail: String { return "repEmail" }
    static var isSubscriptionPlanPurcahsed: String { return "isSubscriptionPlanPurcahsed" }
    static var subscriptionPlanDetails: String { return "subscriptionPlanDetails" }
    static var subscriptionPlanId: String { return "subscriptionPlanId" }
    static var features: String { return "features" }
    static var currentPeriodEnd: String { return "currentPeriodEnd" }
    static var currentPeriodStart: String { return "currentPeriodStart" }
    static var subscriptionPlanID: String { return "subscriptionPlanID" }
    static var perdayUsage: String { return "perdayUsage" }
    static var featureType: String { return "featureType" }
    static var subType: String { return "subType" }
    static var isSubscriptionPlanPurchased: String { return "isSubscriptionPlanPurchased" }
    static var isAllowed: String { return "isAllowed" }
    static var reactionType: String { return "reactionType" }
    static var shouldShowMoxyCoins: String { return "shouldShowMoxyCoins" }
    static var shouldVerifyExpirationOfSubscription: String { return "shouldVerifyExpirationOfSubscription" }
    static var hasCurrentPlanExpired: String { return "hasCurrentPlanExpired" }
    static var latestReceipt: String { return "latest_receipt" }
    static var country: String { return "country" }
    static var surveyMonkeyConfirm: String { return "Web Link 1" }
    static var surveyCompleted: String { return "survey-completed" }
    static var quizCompleted: String { return "quiz-completed" }
    static var isAccountVerified: String { return "isAccountVerified" }
    
    static var subjectBig: String { return "Subject" }
    static var author: String { return "author" }
    static var admin: String { return "admin" }
    static var `primary`: String { return "primary" }
    static var shouldShowNewsDetail: String { return "shouldShowNewsDetail" }
    static var stripeSubscriptionStatus: String { return "stripeSubscriptionStatus" }
    static var hasDisabledAdvertisements: String { return "hasDisabledAdvertisements" }
    static var cfBundleShortVersionString: String { return "CFBundleShortVersionString" }
    static var versionNumber: String { return "versionNumber" }
    static var updateType: String { return "updateType" }
    static var liveStreamingForFollower: String { return "liveStreamingForFollower" }    
    static var pinCreatedAt: String { return "pinCreatedAt" }
    static var isPin: String { return "isPin" }
    static var chat: String { return "chat" }
    static var isChat: String { return "isChat" }
    static var isRegisterToVote: String { return "isRegisterToVote" }
    static var alreadyRegistered: String { return "ALREADY_REGISTERED" }
    static var notRegistered: String { return "NOT_REGISTERED" }
    static var notEligible: String { return "NOT_ELIGIBLE" }
    static var activity: String { return "activity" }
    static var points: String { return "points" }
    static var pdfName: String { return "pdfName" }
    static var pdfUrl: String { return "pdfUrl" }
    static var totalVotes: String { return "totalVotes" }
    static var raceType: String { return "raceType" }
    static var legislation: String { return "legislation" }
    static var planToVoteInNextElection: String { return "planToVoteInNextElection" }
    static var personId: String { return "personId" }
//    static var candidates: String { return "candidates" }
    static var officeLevel: String { return "officeLevel" }
    static var subscribeEmail: String { return "shouldReceiveEmail" }
    static var totalUsersInvited: String { return "totalUsersInvited" }
    static var userType: String { return "userType" }
    static var guest: String { return "guest" }
    static var isForumJoined: String { return "isForumJoined" }
    static var repId: String { return "repId" }
    static var license: String { return "license" }
    static var isGuestPassExpired: String { return "isGuestPassExpired" }
    static var imageData: String { return "imageData" }
    static var contactEmail: String { return "contactEmail" }
}

// MARK: - Api Code
//=======================
enum ApiCode {
    static var success: Int { return 200 } // Success
    static var created: Int { return 201 } // Success
    static var updated: Int { return 202 } // Success
    static var emailNotVerified: Int { return 431 } // email not verified
    static var phoneNotVerified: Int { return 432 } // phone not verified
    static var unauthorizedRequest: Int { return 206 } // Unauthorized request
    static var headerMissing: Int { return 207 } // Header is missing
    static var phoneNumberAlreadyExist: Int { return 208 } // Phone number alredy exists
    static var requiredParametersMissing: Int { return 418 } // Required Parameter Missing or Invalid
    static var fileUploadFailed: Int { return 421 } // File Upload Failed
    static var pleaseTryAgain: Int { return 500 } // Please try again
    static var tokenExpired: Int { return 419 } // Token expired refresh token needed to be generated
    static var userDeleted: Int { return 410 } // Token expired refresh token needed to be generated
    static var accountBlocked: Int { return 401 } // account blocked by admin
    static var blocked: Int { return 403 } // account blocked by admin
    static var liveStreamOver: Int { return 444 } // account blocked by admin
    static var dataNotFound: Int { return 451 } // Unauthorized request
    static var freeLimitReached: Int { return 509 } // Free trial expire
    static var paymentRequired: Int { return 402 } // Free trial expire
    static var notAcceptable: Int { return 406 } // invalid ios Reciept
    static var deleted: Int { return 404 } // deleted by admin


}

//OK: 200,
//CREATED: 201,
//UPDATED: 202,
//NO_CONTENT: 204,
//BAD_REQUEST: 400,
//UNAUTHORIZED: 401,
//PAYMENY_REQUIRED: 402,
//ACCESS_FORBIDDEN: 403,
//URL_NOT_FOUND: 404,
//METHOD_NOT_ALLOWED: 405,
//UNREGISTERED: 410,
//PAYLOAD_TOO_LARGE: 413,
//CONCURRENT_LIMITED_EXCEEDED: 429,
// TOO_MANY_REQUESTS: 429,
//INTERNAL_SERVER_ERROR: 500,
//BAD_GATEWAY: 502,
//SHUTDOWN: 503
