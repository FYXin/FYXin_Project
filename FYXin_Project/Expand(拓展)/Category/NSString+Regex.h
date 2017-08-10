//
//  NSString+Regex.h
//  FYXin_Project
//
//  Created by FYXin on 2017/5/2.
//  Copyright © 2017年 FYXin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface NSString (Regex)

/**
 *  手机号有效性判断
 *
 *  @return 有效性结果，YES 有效，NO 无效
 */
- (BOOL)f_isValidMobileNum;

/**
 *  手机号分服务商有效性判断
 *
 *  @return 有效性结果，YES 有效，NO 无效
 */
- (BOOL)f_isValidMobileNumClassification;

/**
 *  邮箱有效性判断
 *
 *  @return 有效性结果，YES 有效，NO 无效
 */
- (BOOL)f_isValidEmailAddress;

/**
 *  邮编有效性判断
 *
 *  @return 有效性结果，YES 有效，NO 无效
 */
- (BOOL)f_isValidPostalcode;

/**
 *  车牌号有效性判断
 *
 *  @return 有效性结果，YES 有效，NO 无效
 */
- (BOOL)f_isValidCarNum;

/**
 *  中文有效性判断
 *
 *  @return 有效性结果，YES 有效，NO 无效
 */
- (BOOL)f_isValidChinese;

/**
 *  Mac 地址有效性判断
 *
 *  @return 有效性结果，YES 有效，NO 无效
 */
- (BOOL)f_isValidMacAddress;

/**
 *  Url 地址有效性判断
 *
 *  @return 有效性结果，YES 有效，NO 无效
 */
- (BOOL)f_isValidUrlAddress;

/**
 *  IP 地址有效性判断
 *
 *  @return 有效性结果，YES 有效，NO 无效
 */
- (BOOL)f_isValidIPAddress;

/**
 *  简单的身份证号码有效性检测
 *
 *  @return 有效性结果，YES 有效，NO 无效
 */
- (BOOL)f_isSimpleVerifyIdentityCardNum;

/**
 *  精确的身份证号码有效性检测
 *
 *  @return 有效性结果，YES 有效，NO 无效
 */
- (BOOL)f_isAccurateVerifyIdentityCardNum;

/**
 *  银行卡号有效性判断
 *
 *  @return 有效性结果，YES 有效，NO 无效
 */
- (BOOL)f_isValidBankCardNum;

/**
 *  税号有效性判断
 *
 *  @return 有效性结果，YES 有效，NO 无效
 */
- (BOOL)f_isValidTaxNum;

/**
 *  有效性判断
 *
 *  @return 有效性结果，YES 有效，NO 无效
 */
- (BOOL)f_isValidWithMinLenth:(NSInteger)minLenth
                     maxLenth:(NSInteger)maxLenth
               containChinese:(BOOL)containChinese
          firstCannotBeDigtal:(BOOL)firstCannotBeDigtal;

/**
 *  有效性判断
 *
 *  @return 有效性结果，YES 有效，NO 无效
 */
- (BOOL)f_isValidWithMinLenth:(NSInteger)minLenth
                     maxLenth:(NSInteger)maxLenth
               containChinese:(BOOL)containChinese
                containDigtal:(BOOL)containDigtal
                containLetter:(BOOL)containLetter
        containOtherCharacter:(NSString *)containOtherCharacter
          firstCannotBeDigtal:(BOOL)firstCannotBeDigtal;

@end


NS_ASSUME_NONNULL_END
