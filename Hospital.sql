create table clinic
(
    clinic_id   int auto_increment comment '诊所ID'
        primary key,
    clinic_name varchar(50) not null comment '诊所名称'
);

create table department
(
    department_id   int auto_increment comment '科室ID'
        primary key,
    department_name varchar(50) not null comment '科室名称'
);

create table doctor
(
    doctor_id     int auto_increment comment '医生ID'
        primary key,
    name          varchar(50) not null comment '姓名',
    department_id int         not null comment '科室ID',
    title         varchar(50) not null comment '职称',
    phone         varchar(20) null comment '电话',
    constraint doctor_ibfk_1
        foreign key (department_id) references department (department_id)
);

create table clinic_schedule
(
    schedule_id int auto_increment comment '排班ID'
        primary key,
    clinic_id   int         not null comment '诊所ID',
    date        date        not null comment '日期',
    time_slot   varchar(20) not null comment '时间段',
    doctor_id   int         not null comment '医生ID',
    constraint clinic_schedule_ibfk_1
        foreign key (clinic_id) references clinic (clinic_id),
    constraint clinic_schedule_ibfk_2
        foreign key (doctor_id) references doctor (doctor_id)
);

create index clinic_id
    on clinic_schedule (clinic_id);

create index doctor_id
    on clinic_schedule (doctor_id);

create index department_id
    on doctor (department_id);

create table doctor_leave
(
    leave_id   int auto_increment comment '请假ID'
        primary key,
    doctor_id  int  not null comment '医生ID',
    start_date date not null comment '开始日期',
    end_date   date not null comment '结束日期',
    reason     text null comment '请假理由',
    constraint doctor_leave_ibfk_1
        foreign key (doctor_id) references doctor (doctor_id)
);

create index doctor_id
    on doctor_leave (doctor_id);

create table medication
(
    medication_id      int auto_increment comment '药品ID'
        primary key,
    medication_name    varchar(100) not null comment '药品名称',
    usage_instructions text         null comment '用法',
    dosage             varchar(50)  null comment '剂量'
);

create table patient
(
    patient_id int auto_increment comment '患者ID'
        primary key,
    name       varchar(50)  not null comment '姓名',
    gender     varchar(10)  not null comment '性别',
    age        int          not null comment '年龄',
    address    varchar(100) null comment '地址',
    phone      varchar(20)  null comment '电话'
);

create table appointment
(
    appointment_id   int auto_increment comment '预约ID'
        primary key,
    patient_id       int         not null comment '患者ID',
    doctor_id        int         not null comment '医生ID',
    appointment_date datetime    not null comment '预约日期',
    status           varchar(20) null comment '状态',
    constraint appointment_ibfk_1
        foreign key (patient_id) references patient (patient_id),
    constraint appointment_ibfk_2
        foreign key (doctor_id) references doctor (doctor_id)
);

create index doctor_id
    on appointment (doctor_id);

create index patient_id
    on appointment (patient_id);

create table medical_record
(
    record_id    int auto_increment comment '病历ID'
        primary key,
    patient_id   int  not null comment '患者ID',
    date         date not null comment '日期',
    diagnosis    text null comment '诊断',
    prescription text null comment '处方',
    doctor_id    int  not null comment '医生ID',
    constraint medical_record_ibfk_1
        foreign key (patient_id) references patient (patient_id),
    constraint medical_record_ibfk_2
        foreign key (doctor_id) references doctor (doctor_id)
);

create index doctor_id
    on medical_record (doctor_id);

create index patient_id
    on medical_record (patient_id);

create table prescription
(
    prescription_id   int auto_increment comment '处方ID'
        primary key,
    patient_id        int  not null comment '患者ID',
    doctor_id         int  not null comment '医生ID',
    medication_id     int  not null comment '药品ID',
    prescription_date date not null comment '开具日期',
    constraint prescription_ibfk_1
        foreign key (patient_id) references patient (patient_id),
    constraint prescription_ibfk_2
        foreign key (doctor_id) references doctor (doctor_id),
    constraint prescription_ibfk_3
        foreign key (medication_id) references medication (medication_id)
);

create table bill
(
    bill_id          int auto_increment comment '账单ID'
        primary key,
    patient_id       int            not null comment '患者ID',
    doctor_id        int            not null comment '医生ID',
    prescription_id  int            not null comment '处方ID',
    consultation_fee decimal(10, 2) null comment '诊疗费',
    medication_fee   decimal(10, 2) null comment '药品费用',
    total_amount     decimal(10, 2) null comment '总费用',
    bill_date        date           not null comment '账单日期',
    constraint bill_ibfk_1
        foreign key (patient_id) references patient (patient_id),
    constraint bill_ibfk_2
        foreign key (doctor_id) references doctor (doctor_id),
    constraint bill_ibfk_3
        foreign key (prescription_id) references prescription (prescription_id)
);

create index doctor_id
    on bill (doctor_id);

create index patient_id
    on bill (patient_id);

create index prescription_id
    on bill (prescription_id);

create index doctor_id
    on prescription (doctor_id);

create index medication_id
    on prescription (medication_id);

create index patient_id
    on prescription (patient_id);

create table room
(
    room_id       int auto_increment comment '诊室ID'
        primary key,
    room_name     varchar(50) not null comment '诊室名称',
    department_id int         not null comment '科室ID',
    constraint room_ibfk_1
        foreign key (department_id) references department (department_id)
);

create table doctor_schedule
(
    schedule_id int auto_increment comment '排班ID'
        primary key,
    doctor_id   int         not null comment '医生ID',
    date        date        not null comment '日期',
    time_slot   varchar(20) not null comment '时间段',
    clinic_room int         not null comment '诊室ID',
    constraint doctor_schedule_ibfk_1
        foreign key (doctor_id) references doctor (doctor_id),
    constraint doctor_schedule_ibfk_2
        foreign key (clinic_room) references room (room_id)
);

create index clinic_room
    on doctor_schedule (clinic_room);

create index doctor_id
    on doctor_schedule (doctor_id);

create index department_id
    on room (department_id);

create table schedule
(
    schedule_id int auto_increment comment '排班ID'
        primary key,
    date        date        not null comment '日期',
    time_slot   varchar(20) not null comment '时间段',
    doctor_id   int         not null comment '医生ID',
    constraint schedule_ibfk_1
        foreign key (doctor_id) references doctor (doctor_id)
);

create index doctor_id
    on schedule (doctor_id);

create table time_table
(
    time_table_id int auto_increment comment '时间表ID'
        primary key,
    doctor_id     int         not null comment '医生ID',
    date          date        not null comment '日期',
    time_slot     varchar(20) not null comment '时间段',
    constraint time_table_ibfk_1
        foreign key (doctor_id) references doctor (doctor_id)
);

create index doctor_id
    on time_table (doctor_id);


