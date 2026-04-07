package com.school.dto;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
@Builder
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class CertifiCateVO {
private String	cerNum;
private String	claNum;
private String	cerName;
private String cerSaveName;
private String cerSavePath;
private Date cerRegDate;

}
