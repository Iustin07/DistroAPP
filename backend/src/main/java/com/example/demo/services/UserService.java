package com.example.demo.services;
import com.example.demo.config.JwtTokenUtil;
import com.example.demo.dto.CustomUser;
import com.example.demo.dto.UserDTO;
import com.example.demo.model.Password;
import com.example.demo.model.User;
import com.example.demo.repository.UserRepository;
import com.example.demo.vo.UsersQueryVO;
import com.example.demo.vo.UsersUpdateVO;
import com.example.demo.vo.UsersVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.NoSuchElementException;
import java.util.Optional;
import java.util.stream.Collectors;
@Slf4j
@Service
public class UserService {
    @Autowired
    JwtTokenUtil jwtTokenUtil;
    @Autowired
    private UserRepository usersRepository;
    @Autowired
    private RoleService roleService;
    public Long save(UsersVO vO) {
        User bean = new User();
        BeanUtils.copyProperties(vO, bean);
        bean.setRole(roleService.convertToEntity(roleService.getByName(vO.getUserRole())));
        bean = usersRepository.save(bean);
        return bean.getUserId();
    }

    public void delete(Long id) {
        usersRepository.deleteById(id);
    }

    public ResponseEntity<Object> changePaswword(Password passwords, HttpServletRequest httpServletRequest) {
        String token = httpServletRequest.getHeader("Authorization");
        token = token.substring(6);
        Long userId = jwtTokenUtil.getIdFromToken(token);
        Optional<UserDTO> foundUser = Optional.of(getById(userId));
        if (foundUser.isEmpty()) {
            return new ResponseEntity<>("User not found for changing passwords", HttpStatus.BAD_REQUEST);
        }
//        if(foundUser.get().getUserId()==3){
//            return  new ResponseEntity<>("can't do this operaion on this user", HttpStatus.FORBIDDEN);
//        }
        User bean = new User();
        BeanUtils.copyProperties(foundUser.get(), bean);
        bean.setPasswordHash(getEncodePassword(passwords.getNewPassword()));
        bean.setRole(roleService.convertToEntity(roleService.getByName(foundUser.get().getUserRole())));
        usersRepository.save(bean);
        return new ResponseEntity<>(HttpStatus.OK);
    //}
//        else{
//            //throw new PasswordDoNotMatch("Passwords do not match");
//            return  new ResponseEntity<>("Password do not match",HttpStatus.NOT_MODIFIED);
//        }


    }
    public void update(Long id, UsersUpdateVO vO) {
//        Users bean=new Users();
//        Users foundUser=requireOne(id);
//        bean.setUserId(foundUser.getUserId());
//        bean.setCreatedOn(foundUser.getCreatedOn());

        /**de adaigat alte campuri if needed*/
        User bean=requireOne(id);
        System.out.println("user id is "+bean.getUserId());
        //BeanUtils.copyProperties(vO, bean);
        if(!vO.getAddress().isEmpty())
            bean.setAddress(vO.getAddress());
        if(!vO.getPhoneNumber().isEmpty())
            bean.setPhoneNumber(vO.getPhoneNumber());
        if(vO.getSalary()!=null)
            bean.setSalary(vO.getSalary());
        if(
                !vO.getDriverLicense().equals(bean.getDriverLicense()) ){
            bean.setDriverLicense(vO.getDriverLicense());
        }
        if(vO.getUserRole()!=null && !vO.getUserRole().isEmpty())
            bean.setRole(roleService.convertToEntity(roleService.getByName(vO.getUserRole())));
        usersRepository.save(bean);
    }

    public UserDTO getById(Long id) {
        User original = requireOne(id);
        System.out.println(original.getRole().getRoleId());
        System.out.println(original.getRole().getName());
        //System.out.println(original.toString());
        return toDTO(original);
    }

    public Page<UserDTO> query(UsersQueryVO vO) {
        throw new UnsupportedOperationException();
    }

    public UserDTO toDTO(User original) {
        UserDTO bean = new UserDTO();
        BeanUtils.copyProperties(original, bean);
        bean.setUserRole(original.getRole().getName());
        System.out.println(bean.getUserRole());
        return bean;
    }

    public User requireOne(Long id) {
        return usersRepository.findById(id)
                .orElseThrow(() -> new NoSuchElementException("Resource not found: " + id));
    }
    public UserDTO getbyName(String username){
        return toDTO(usersRepository.findUsersByUsername(username));
    }
    public List<CustomUser> getAllUsers(){
        return usersRepository.findAll().stream().filter(item->!(item.getRole().getName().equals("admin"))).map(
                element->new CustomUser(element.getUserId(),element.getUsername())

        ).collect(Collectors.toList());
    }
    public List<CustomUser> getAllSpecific(String searchedRole){
        return usersRepository.findAll().stream().filter(item->item.getRole().getName().equals(searchedRole)).map(
                element->new CustomUser(element.getUserId(),element.getUsername())

        ).collect(Collectors.toList());
    }
    private String  getEncodePassword(String newPassword) {
        BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        return passwordEncoder.encode(newPassword);


    }
    public double getWages(){
        return usersRepository.findAll().stream()
                .reduce(0.0, (subtotal, element) -> subtotal + element.getSalary(),Double::sum);

    }
}
