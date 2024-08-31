import { IsEmail, IsNotEmpty, IsString, Length, Validate } from "class-validator";
import { MatchPassword } from "src/decorators/matchpass.decorator";

export class RegisterDto {
    id:string;
    @IsEmail()
    email: string;

    @IsString()
    @Length(6, 20)
    password: string;

    @IsNotEmpty()
    @Validate(MatchPassword, ['password'])
    confirmPassword: string;
}

export class LoginDto {
    @IsEmail()
    email:string;

    @IsString()
    @Length(6, 20)
    password: string;
}